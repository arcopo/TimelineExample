//  Copyright (c) 2025 Commonwealth Bank. All rights reserved.

import SwiftUI

/// Displays the timeline (dashed line with an icon) for a progress tracker step.
///
/// This view draws a dashed vertical line and places the step indicator icon in the correct position
/// based on the timeline position (first, middle, last, or none). The dashed pattern and icon are
/// designed to match the Figma spec for the Progress Tracker.
///
/// [Figma reference](https://www.figma.com/design/d5nxem1piXkREvJcLmvUdL/%F0%9F%9A%A7-Progress-Tracker-(Web-%2B-App)?node-id=2227-29078&p=f&t=xcxMNS4QrRpGCqus-0)


struct TextHeightReader: View {
    let text: String
    let font: Font
    @Binding var height: CGFloat

    var body: some View {
        Text(text)
            .font(font)
            .background(GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        height = geometry.size.height
                    }
            })
    }
}

public struct ProgressTrackerTimelineView: View {
    let stepIndicator: StepIndicator
    let timelinePosition: TimelinePosition
    let topGap: CGFloat = 6
    
    @Binding var headingHeight: CGFloat
    
    public var body: some View {
        VStack(spacing: 0) {
            switch timelinePosition {
            case .first:
                // For the first step, display the icon at the top, then a dashed line extending downward.
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 2, height: topGap+headingHeight/2, alignment: .center)
                stepIndicator.image
                Rectangle()
                    .fill(Color.clear)
                    
                    .frame(minWidth: 1, idealWidth: 1, maxWidth: 1, minHeight: nil, idealHeight: nil, maxHeight: .infinity)
                    .overlay(DashPatternOverlay())
                    // arcopo make the fill clear and no foreground
            case .middle:
                // For a middle step, draw a dashed line above, the icon, and a dashed line below.
                ZStack(alignment:.top) {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(minWidth: 1, idealWidth: 1, maxWidth: 1, minHeight: nil, idealHeight: nil, maxHeight: .infinity)
                        .overlay(DashPatternOverlay())
                    stepIndicator.image
                        .offset(y: topGap+headingHeight/2)
                        
                }
                
                
            case .last:
                // For the last step, draw a dashed line above, then the icon.
                Rectangle()
                    .fill(Color.clear)
                    .frame(minWidth: 1, idealWidth: 1, maxWidth: 1, minHeight: nil, idealHeight: nil, maxHeight: .infinity)
                    .overlay(DashPatternOverlay())
                stepIndicator.image
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 2, height: topGap+headingHeight/2, alignment: .center)
            case .none:
                // If no timeline is required, just show the icon.
                stepIndicator.image
            }
        }
        .frame(width: 30)
        .background(Color.clear)
    }
}

/// A helper view that draws a dashed line pattern.
///
/// This view uses a simple path with a dash style to overlay a dashed line.
struct DashPatternOverlay: View {
    var body: some View {
        GeometryReader { geo in
            let dashLength: CGFloat = 6
            let gapLength: CGFloat = 6
            let totalPatternLength = dashLength + gapLength
            
            // Find the largest integer multiplier for the dash and gap pattern
            let numberOfPatterns = floor(geo.size.height / totalPatternLength)
            
            // Scale the dash and gap based on the number of full patterns
            let scaledDashLength = (geo.size.height / numberOfPatterns) * (dashLength / totalPatternLength)
            let scaledGapLength = (geo.size.height / numberOfPatterns) * (gapLength / totalPatternLength)
            
            // Adjust phase so it always starts and ends halfway through a dash
            let adjustedPhase = scaledDashLength / 2

            Path { path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 0, y: geo.size.height))
            }
            .strokedPath(StrokeStyle(lineWidth: 2, dash: [scaledDashLength, scaledGapLength], dashPhase: adjustedPhase))
            .foregroundColor(.secondary)
        }
    }
}







#Preview {
    @Previewable @State var headingHeight: CGFloat = 12
    ProgressTrackerTimelineView(stepIndicator: .complete, timelinePosition: .middle, headingHeight: $headingHeight)
}
